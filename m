From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Permanent disk shutdown instead of soft/hard reset?
Date: Wed, 10 Oct 2007 20:12:27 -0400
Message-ID: <76366b180710101712j177e17beqa244226420722a5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:2409 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbXJKAM2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 20:12:28 -0400
Received: by rv-out-0910.google.com with SMTP id k20so333823rvb
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 17:12:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm currently running into a situation where I have 4 SATA drives in a
striped array where one of the drives is failing (/ has failed). The
single drive failure manifests itself as ext3 errors and libata SCSI
media errors which occur non-stop as software attempts to read/write
to the mounted array. Because libata is seeing media errors, the bad
drive endlessly soft resets while the software is still running and
attempting to access the drive. This winds up hanging the entire
system because the software (consider it a 'find' command running on
the drive) occurs in the init.d boot scripts. The end result is that a
login prompt is never reached until the software finishes what it is
doing and hours of soft resets have occurred.

Is there any way that this behavior can be stopped by permanently
disconnecting the drive after a configurable number of errors that
would otherwise soft reset? Does the layer allow for the concept of a
full disk shutdown rather than a reset? I assume this would have to
forcefully unmount any active mounts which use the drive/array to
ensure that no subsequent cmds would cause libata to attempt to
reconnect to the bad drive(s). Is this even possible?

Using smartd is invaluable for detecting failing drives, but when the
failed drive prevents the system from booting, it is hard to recover
remotely. It may not be possible to "recover" (e.g. If the failed
drive is the boot drive), but that should be up to the system
designer. In my case, I would still want to boot into the system (I do
not boot from the array), establish network connectivity, and "phone
home" that a permanent hardware failure has occurred in the array.

Thanks,
-Andrew
