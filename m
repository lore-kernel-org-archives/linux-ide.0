Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7FA1BC07B
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747195357; cv=none; b=eaS8kHjLD090gqvNCECZjzvGRJZWn2EldpLA0dLtJmOcS7qLJ53pyQNjcEMmjT6e3ajysUJt9JChr5ewmdjypFX2pXgpjFX3iWoadPRIJTT1JsMD58f7KUT6T37njYeJlLdejkXrVZfPemr+ZjighOh3S6FGLMUh4FIZZkqU0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747195357; c=relaxed/simple;
	bh=pG0QZc/4tE9//2nJfrpiX5ILt9BagwEUEKwgz26pMRc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eDVc1UQIhM+THZhwLj2+ecEKpDqVmdAu7ReF6uQbhDTzyxGxpovGaoetBZeeXYvX2a2yU9hyhoa+S7h0eYWjtkE6S/sFVbeAHLr6aDnKSUhHFBp5N1nI+N2N8THTId/m1wg4+858JxSR8YaNZburczbW+Dc8kMIdeYAlXstkEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7L69886; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7L69886"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2A82C4CEEF
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 04:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747195357;
	bh=pG0QZc/4tE9//2nJfrpiX5ILt9BagwEUEKwgz26pMRc=;
	h=From:To:Subject:Date:From;
	b=h7L698866MRaLeZ32s9v9RLUTR5eqaD3R3ykA/71Hi4+ogU0bBTu15bbUVLNfF1oG
	 2DuYaL9fn+EUoVXsHwCJTGfnwBV1l6ZCgY7nG5AJud75Yo5vOtukBx1F42qkpsoR+E
	 6KWYFvVQ5kA1zcaEpF1bXw9UZ53jc6wpoumjxK4B2tGOvXy4Ak+7LO4rLV1rBFIn5p
	 sq20Flj6kg/l3AViDYuAe2yvdrvVLrtnZtIkeiGMUPwsG0KN6zl4UMSo9A+fd03A67
	 Z9W+TqUh/j3bqeI1pjJU0DdGVb6ROHNy50i9XE15we/dXrBGdb4FEQTjNlM4s7Zt9W
	 PN4zKWT4STY9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ECB8AC41612; Wed, 14 May 2025 04:02:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ide@vger.kernel.org
Subject: [Bug 220121] New: Not found
Date: Wed, 14 May 2025 04:02:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tungdangthanh23032004@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220121-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220121

            Bug ID: 220121
           Summary: Not found
           Product: IO/Storage
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: tungdangthanh23032004@gmail.com
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
