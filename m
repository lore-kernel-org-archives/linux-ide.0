From: Marc Bevand <mb@opensc.org>
Subject: Re: [sata_sil24] disks not detected (RESOLVED)
Date: Sat, 19 Nov 2005 11:02:37 +0100
Message-ID: <20051119100237.GA27926@bam.epita.fr>
References: <20051113124650.GA21127@bam.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.255.125]:35596 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S1750966AbVKSKCz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Nov 2005 05:02:55 -0500
Content-Disposition: inline
In-Reply-To: <20051113124650.GA21127@bam.epita.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Marc Bevand wrote:
| 
| Remember the patch you made to sata_sil24 to correctly detect disks
| attached to the controller [1] ? At this time I was using only one
| SiI3124 controller, and it worked well. But today I just tried to
| use 2 controllers with 4 disks attached to each of them (8 total disks),
| and 2 of the disks are not detected [...]

The various sil24 patches that have been applied today to libata-dev
(see below) have resolved my issue. Thanks Tejun.

[PATCH 1/4] sil24: add sil24_restart_controller
[PATCH 2/4] sil24: use SRST for phy_reset 
[PATCH 3/4] sil24: add ATAPI support 
[PATCH 4/4] sil24: make error_intr less verbose

-- 
 Marc Bevand                              http://epita.fr/~bevand_m
 Computer Science School EPITA - System, Network and Security Dept.
