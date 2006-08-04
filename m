From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: improve initialization and legacy handling,
 take#2
Date: Sat, 05 Aug 2006 06:13:45 +0900
Message-ID: <44D3B889.5090207@gmail.com>
References: <11547252923301-git-send-email-htejun@gmail.com> <20060804210556.GB18792@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:17842 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161379AbWHDVNw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 17:13:52 -0400
Received: by nz-out-0102.google.com with SMTP id n1so110225nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 14:13:51 -0700 (PDT)
In-Reply-To: <20060804210556.GB18792@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Dave Jones wrote:
> On Sat, Aug 05, 2006 at 06:01:32AM +0900, Tejun Heo wrote:
>  > Hello, all.
>  > 
>  > This is the second take of improve-init-and-legacy patchset.  This
>  > patchset contains patches from Jeff Garzik, Alan Cox, Dave Jones and
>  > me to fix/clean up initializaton and legacy handling.
> 
> It does ?  I don't recall writing any of these :)

Oh.. that credit is for the following patch.

====
http://thread.gmane.org/gmane.linux.ide/12393/focus=12395

[PATCH 5/5] libata: fix ata_device_add() error path

* dereferences null host_set->ports[] element.
* calls scsi_remove_host() on not-yet-added shost.

This patch fixes both bugs.  The first problem was spotted and initial
patch submitted by Dave Jones <davej <at> redhat.com>.  The second 
problem was mentioned and fixed by Jeff Garzik <jgarzik <at> pobox.com> 
in a larger cleanup patch.
====

The patch got moved to another patchset but I forgot to move that part 
from head message.  Free credit! :)

-- 
tejun
