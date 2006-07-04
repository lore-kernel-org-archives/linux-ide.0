From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT][PATCHSET] hotplug polling
Date: Wed, 05 Jul 2006 05:28:01 +0900
Message-ID: <44AACF51.7070204@gmail.com>
References: <11520225771424-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:27093 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932379AbWGDU1g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 16:27:36 -0400
Received: by py-out-1112.google.com with SMTP id t32so1959121pyc
        for <linux-ide@vger.kernel.org>; Tue, 04 Jul 2006 13:27:36 -0700 (PDT)
In-Reply-To: <11520225771424-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Well, the port-exclusive case is dumb but understandable; however,
> sata_via (vt8237) takes it to the next level and may lock up if any
> available port in the host_set is active when a SCR reg is accessed,
> so it needs host_set-exclusive version.  It took me two days of
> boredom to figure out that things can be made THAT dumb.  Their new
> AHCI controller also seems to require host_set-wide EH ops to recover
> from errors.  Well, I guess they consider requiring host_set-wide ops
> a feature or something.  :-( Note that this means that the current
> libata EH may lock up the whole machine on vt8237 if EH occurs at a
> bad time.

Update: vt8237 failed to survive over-night test.  It died even with 
host_set-wide exclusion.  I'm dropping hp-poll support from sata_via.

-- 
tejun
