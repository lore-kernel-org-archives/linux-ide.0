From: Tejun Heo <htejun@gmail.com>
Subject: Re: Permanent disk shutdown instead of soft/hard reset?
Date: Tue, 23 Oct 2007 17:18:00 +0900
Message-ID: <471DAE38.6070906@gmail.com>
References: <76366b180710101712j177e17beqa244226420722a5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:22307 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbXJWISJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 04:18:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1420931rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 01:18:08 -0700 (PDT)
In-Reply-To: <76366b180710101712j177e17beqa244226420722a5a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> I'm currently running into a situation where I have 4 SATA drives in a
> striped array where one of the drives is failing (/ has failed). The
> single drive failure manifests itself as ext3 errors and libata SCSI
> media errors which occur non-stop as software attempts to read/write
> to the mounted array. Because libata is seeing media errors, the bad
> drive endlessly soft resets while the software is still running and
> attempting to access the drive. This winds up hanging the entire
> system because the software (consider it a 'find' command running on
> the drive) occurs in the init.d boot scripts. The end result is that a
> login prompt is never reached until the software finishes what it is
> doing and hours of soft resets have occurred.
> 
> Is there any way that this behavior can be stopped by permanently
> disconnecting the drive after a configurable number of errors that
> would otherwise soft reset? Does the layer allow for the concept of a
> full disk shutdown rather than a reset? I assume this would have to
> forcefully unmount any active mounts which use the drive/array to
> ensure that no subsequent cmds would cause libata to attempt to
> reconnect to the bad drive(s). Is this even possible?

If it's a RAID array, that's the job of md (or dm).  If it isn't a RAID
array, giving up on the drive doesn't really help anybody.  As long as
the drive is up and willing to talk, libata talks to the drive as
requested by upper layers.

-- 
tejun
