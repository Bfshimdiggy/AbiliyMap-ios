import SwiftUI

struct UserIssuesView: View {
    @State private var userIssues: [Issue] = []
    @EnvironmentObject var firebaseService: FirebaseService

    var body: some View {
        VStack {
            Text("Your Submitted Issues")
                .font(.title)
                .foregroundColor(.primary)
                .padding()

            if userIssues.isEmpty {
                Text("You haven't submitted any issues yet.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List(userIssues) { issue in
                    VStack(alignment: .leading, spacing: 10) {
                        // Display Category
                        Text("Category: \(issue.category)")
                            .font(.headline)
                            .foregroundColor(.primary)

                        // Display Business Name or County based on category
                        if issue.category == "Private Business" {
                            Text("Business Name: \(issue.businessName ?? "N/A")")
                                .foregroundColor(.primary)
                        } else if issue.category == "City Infrastructure" {
                            Text("County: \(issue.county ?? "N/A")")
                                .foregroundColor(.primary)
                        }

                        // Display Address
                        Text("Address: \(issue.address)")
                            .foregroundColor(.primary)

                        // Display Issue Description (updated font/color)
                        Text("Description: \(issue.issueDescription)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            loadUserIssues()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
    }

    private func loadUserIssues() {
        firebaseService.getUserIssues { issues in
            self.userIssues = issues
        }
    }
}
