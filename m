From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Other Problems with Marvell Driver - 7042 (2.6.23)...
Date: Wed, 31 Oct 2007 12:06:46 -0400
Message-ID: <4728A816.8020608@garzik.org>
References: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com> <45ED682A.9040408@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760010AbXJaQG7@vger.kernel.org>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>
List-Id: linux-ide@vger.kernel.org

Morrison, Tom wrote:
> I am running the 'latest' kernel retrieved from Kumar Gala's
> Powerpc git tree (mainly because I am running on a MPC8548 board) 
> and it appears to be in the full 2.6.23 version while the sata_mv 
> driver version seems to be 1.01. 
> 
> I have searched the archives, and there has been some discussion
> of a regression in the Marvell driver, but I seem to have a 
> different symptom from Olaf's (I am not running a 64bit kernel - 
> and I am *not* running with large (36bit) physical and resources - 
> so I wouldn't have the same type of IOMMU issues)
> 
> Below in the error output (using ATA_DEBUG) the driver sees the 
> two drives (3 partitions on /dev/sda & 2 partitions on /dev/sdb)
> and apparently sets up everything correctly for standard access...
> 
> But, when I try to mount a partition - it freezes up and gets I/O
> errors?
> Can someone give me any hints of things to try?

First you need to try 2.6.23.1 rather than 2.6.23, because it contains a 
critical sata_mv fix.

	Jeff
