Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E7200C98
	for <linux-ide@vger.kernel.org>; Wed, 13 Nov 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498808; cv=none; b=qlaXgZFCVoEeJtqoOV1v0rLjNx22Gpbagj/2359RvRH33RZ21nEny3372MBQ37a9we5p1El84PDW8s3UbzTeYNEVA8eb7w4ABCNdAiozYZ+8tddAQxF+3c+32Evd1Ne/9ZfM3glEgmV1cHTJIX9EAj0x2mT3CkoPgHT2npaYqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498808; c=relaxed/simple;
	bh=ILJZh6WF4yNs2nhkX6E7wnrVl/EIqVlVBpVFpAYhzoo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYPczKdSA4eDG87kR1XdWxXLTNh14mCovNgGqcjAgxJX5ZJvqzdqKx8gUR2hoxnP+t5V5YlzSJZnHyrjt8gVdr3OyW4obbvHEOpYbZ5dfgUQw59nzn37wOV0XVzDTla0qVbmBueOg00XNGPSIr6zZttX0ZgCbu00oefR95j3Q74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJhyb0cm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJhyb0cm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E581C4CED5
	for <linux-ide@vger.kernel.org>; Wed, 13 Nov 2024 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731498808;
	bh=ILJZh6WF4yNs2nhkX6E7wnrVl/EIqVlVBpVFpAYhzoo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gJhyb0cmgAkjnX/HrfOmhusiPMfv9oh3LqczwRI3i9/Z69xPNjQujMJfThu8OhcUi
	 ke9VN2C2tMSTBAE0neDSX1D2RhszYhAQyhV+pNBY47EmuoapcqXlShllHjEAdNAFTl
	 1bT0Zx1QTsnjiPIJgIDHXzA31Bq6uZ3Nlzqjovq2UMDeRJzIyrkBICPGvxEni4xXRY
	 JfBebH0d3f/rcSFlbFXVDMGEmpWEBU3InCbgXcjF3XZ6ySHp+yxLESUbRt9JAzn7TU
	 XRplBkXuxK7itxp/SAdtILauyLvZ7DvAiroPpxifcZn6+Tyi3kSRYFW29sUPempLv1
	 BR6aBihxnh/zQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 038F6CAB786; Wed, 13 Nov 2024 11:53:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date: Wed, 13 Nov 2024 11:53:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: wlmqljj@qq.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205107-11633-Lb1xjrD0T7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205107-11633@https.bugzilla.kernel.org/>
References: <bug-205107-11633@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205107

Li Jiajun (wlmqljj@qq.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |wlmqljj@qq.com

--- Comment #22 from Li Jiajun (wlmqljj@qq.com) ---
Inspired by #21, we could solve this by add a new udev rule.
/etc/udev/rules.d/01-manage_start_stop.rules:
For kernel 6.1 and after:
ACTION=3D=3D"add|change", DRIVERS=3D=3D"usb-storage|uas", SUBSYSTEM=3D=3D"s=
csi_disk",
ATTR{manage_runtime_start_stop}=3D"1", ATTR{manage_shutdown}=3D"1"

For kernel 6.1 before:
ACTION=3D=3D"add|change", DRIVERS=3D=3D"usb-storage|uas", SUBSYSTEM=3D=3D"s=
csi_disk",
ATTR{manage_start_stop}=3D"1"

I think this is a common issue for those people using usb2sata adapter.
To sovle this issue on kernel side, We need add some quirk configurations f=
or
- drivers/usb/storage/scsiglue.c
-- function device_configure()
and
-drivers/usb/storage/uas.c
-- function uas_device_configure()
to perform better.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
