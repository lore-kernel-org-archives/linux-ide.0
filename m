Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBF1F8906
	for <linux-ide@vger.kernel.org>; Wed, 13 Nov 2024 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500888; cv=none; b=r2qZj6amcHcUKTrQUJcnuj9YVbQq+kW5si8lgUvZrh1CGEnePReTruGs3nuGn5FqooQ1a00muk/bH48iDl/gR7zdZ7ubU2XboQJpZ/PMTXmUO2QwJYbPPjOn1riBEJWPjnhL1aq2Gp5qYovsu4MZiVO/oRmtyzk2JsCn11+gPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500888; c=relaxed/simple;
	bh=RAjEctoTIlz7xkhR+XvhjvQEh2NW7UFbcIIBlZtdYoE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZxKN2s+FBQ/48+eOA+kL+m9IuORIHXHIj7b9thXM5mOjTQcI+NGtFoNSgnJ6tNHOQgbJn6O72ephkmn+tqZO5N/N8mPYl6xJfriOlWa88VKzECVoKII5mzsk/fCA/522VD4QwhKzWE2ICPnnvSP777YNQRc99Yz+P1j0retAYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOBMolCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOBMolCM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A99CC4CED7
	for <linux-ide@vger.kernel.org>; Wed, 13 Nov 2024 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731500887;
	bh=RAjEctoTIlz7xkhR+XvhjvQEh2NW7UFbcIIBlZtdYoE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UOBMolCMwyaJkHQ/VsVJxVEXCmKa4w3Owk6kk13Mg/pbh0ogaLpLVmg1xXUUrjCGY
	 0uHXx7Y5V1plEAHQ59PJcj5fdN+7En/8ZMX4dMVeMSZ/Rshmm8oBJzOBA5YfexQE9w
	 H+6jrD/aFlqpeTrc72G8kRJtHg8/+JD1Yl76iqC0j5yWHhhAMdVQHZhJhp85M6otBa
	 lETTmTE+M3rTk7YKaTdv3n5c1R3MoHc51hE77D+iQBSXrIjEBOx5LzLGJiS4PfH3NE
	 RBeoRdOLCtqTOqVMS/7/oqISVDjRm3Mp1MN+GfE08axEJr/JeS0LCiINESTchgOnwe
	 VlJWQvro1H9dQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6B584C53BC5; Wed, 13 Nov 2024 12:28:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date: Wed, 13 Nov 2024 12:28:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: reagentoo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205107-11633-lREyd0OwsE@https.bugzilla.kernel.org/>
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

--- Comment #23 from Dmitry Baranov (reagentoo@gmail.com) ---
(In reply to Li Jiajun from comment #22)
> Inspired by #21, we could solve this by add a new udev rule.
> I think this is a common issue for those people using usb2sata adapter.

Also discards should not be forgotten.
provisioning_mode=3Dunmap is not enabled by default for external USB device=
s.
My current rules file for kernel 6.6:
---
$ cat /etc/genkernel.d/etc/udev/rules.d/10-usb-storage.rules=20
# ASMedia Technology Inc. ASM236X series
ACTION=3D=3D"add", SUBSYSTEM=3D=3D"scsi_disk", ATTRS{idVendor}=3D=3D"174c",
ATTRS{idProduct}=3D=3D"2364", ENV{LABEL}=3D"edisk"

# JMicron Technology Corp. / JMicron USA Technology Corp. USB 3.1 Storage
Device
ACTION=3D=3D"add", SUBSYSTEM=3D=3D"scsi_disk", ATTRS{idVendor}=3D=3D"152d",
ATTRS{idProduct}=3D=3D"0580", ENV{LABEL}=3D"edisk"

ENV{LABEL}=3D=3D"edisk", DRIVERS=3D=3D"uas", ATTR{provisioning_mode}=3D"unm=
ap"
ENV{LABEL}=3D=3D"edisk", DRIVERS=3D=3D"usb", ATTR{manage_system_start_stop}=
=3D"1"
---

Can be mixed with ATTRS{serial}=3D=3D"XXXXXXXXXXXXXX" to enable discards /
start_stop on unique devices.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
