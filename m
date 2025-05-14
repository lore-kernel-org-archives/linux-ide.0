Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD4288DA
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 04:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747195875; cv=none; b=HbIUTcjnC7p0LGyc5uzlUPURgWoGcrDTiRIRIse3+hVeMQFTxq/b/nX8ZX8bulSUa/5mU5tSMAVdWd8P1OxC4oRe3leaO9aEwa0gdjbdUOyzP4ZzpbP0o3SHYl6/AFLQtIi4u+H2hNL4saTN31qphLBqSuhYSRLQUtcZYrXYXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747195875; c=relaxed/simple;
	bh=mn7s1IYO9pO3OWw5kAsBA9A61QKMXezZMLFFptzPDFk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eN/x1esYBJxvp4MjRtxU5q1VwEtvMnARYeZwcnAC9LDfNjUzojvKbI2t0TRhAzlyQ8vY1t7YRMzG6o/YWJYNq+bxAu8SEXNzQSlrzehn0MG6UeCw+9476VuhjEk7O8w0w/Q/hLzk93/sjUPwUuO8HFr5UeOPeQOtrmxPBcjJY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc0eS0MM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc0eS0MM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE2F0C4CEEF
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 04:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747195874;
	bh=mn7s1IYO9pO3OWw5kAsBA9A61QKMXezZMLFFptzPDFk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Uc0eS0MMy/wT7k8OGyc5RsxAmDrq72cp4O5KMwDLKO46diab2OAnxzvTbdfzq+h5a
	 xzYTKPFT4s9sThe4OGDn+bYc/xcCKfgo85D2JtvdNS/w7zD2PFn8NphS83YneZPksA
	 mrD0PtWUtF6ZC4z1YncF62+rU1EIQzpNBm4sk2gnH+eT4Uts/oCWAvKxegvDwXDjVx
	 5CGpTWufBdHjoaIsbVxD6QhYVni/uh/N39Jxc4Ys1f4CdRzpxPAVy0R3WesgOdm7KS
	 QivsM8aWzkAiYJbSgXPnwgfn6tUnnzdsnYVN5e75RjqojANkm1ttyv4JUvb0i/Knhm
	 BVJMWCEztR3Iw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D4202C41613; Wed, 14 May 2025 04:11:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ide@vger.kernel.org
Subject: [Bug 220121] Not found
Date: Wed, 14 May 2025 04:11:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tungdangthanh23032004@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution
Message-ID: <bug-220121-11633-oksugqsT42@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220121-11633@https.bugzilla.kernel.org/>
References: <bug-220121-11633@https.bugzilla.kernel.org/>
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

Tung (tungdangthanh23032004@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|ANSWERED                    |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
