Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EAC2F2
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747195546; cv=none; b=KkzkQz2BEyxEh4atEP0ul1hw4GuTZDRiRMb9vt8SNb5pRbxPB3pjOfTQ7W7brdpZY+mwoj1/HdxFekxWH7oBE5NYTwe+A0fM5iYuQ4ziDYbGpD9BVUkz2tzWVRATf5Pav0KIvFvVrf6ABkJNaK5ioL2y8KZJkBQCKpyt1t1+zJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747195546; c=relaxed/simple;
	bh=7b1hQ08KirU6xDoqMbi9W39DDTI9xFBeql6/+Kg7/1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ebxk8yitbgfsJIHT8360AcZGe+iyhawmBtRUOa0fjBgBXNs8pdUKWXQAIX2omVe7Vsh2oL4TZCFR03bJho0yb7dn/t2spDxYf8qNTQwkM9f0oh/RwRAZWeTKZCvuV7JjowOhzN2N7X9mMOeka2h52m3+gJ76enSe3JSG5fNE8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9MCzSd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9MCzSd9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB1D2C4CEEE
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747195545;
	bh=7b1hQ08KirU6xDoqMbi9W39DDTI9xFBeql6/+Kg7/1Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z9MCzSd9DGddD1m3e1Wza9dC4q02fTzhqUd3HVcq7aR+yDJF7DJQUawmZHpdZ4M8M
	 pOVzWzhDjqedbEL3NDNoxKXxJBVfEzOmnK3oiJq5KQ16XYAEFbOuz9NnS8l0X+P8ef
	 zugjqK9xUtQKf2Uk9QaOMH4RS2rSthEZn6ozu6+WjckPvRLqy0TYR/2SI2aG7awbQ1
	 mnIAnoweImHdxCGG+i5AkD4rfJIn1qU0MiXJGkC4FUlEIaBFzgB4XFHXul4sY3fZof
	 oG5xoq21iYJyfL6GigVXPW89G8flSUR12fZOir9JioTRusdFIb9DGA6bXgQ49PZe4h
	 dgzjw55nF9S/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9DF37C41613; Wed, 14 May 2025 04:05:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ide@vger.kernel.org
Subject: [Bug 220121] Not found
Date: Wed, 14 May 2025 04:05:45 +0000
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
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220121-11633-vwkVNjayE7@https.bugzilla.kernel.org/>
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
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
