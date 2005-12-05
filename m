From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: [PATCH] sata_sil: greatly improve DMA handling
Date: Mon, 05 Dec 2005 22:50:54 +0200
Message-ID: <dn297e$aip$1@sea.gmane.org>
References: <20051203200438.GA3770@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751409AbVLEU4D@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:

> 
> To make it easy for others to test, since there are merge conflicts,
> I've combined the two previous sata_sil patches into a single patch.
> 
> Verified here on my 3112 (Adaptec 1210SA).
> 
> I'm especially interested to hear from anyone willing to test on a
> SI 3114 (4-port).
> 
> 

Please cc me as I'm not subscribed....


ASUS K8N-E-Deluxe, nForce3 250Gb chipset, AMD Athlon64 3200+ running x86_64

Sil 3114A with 3 Maxtor MaxLine III+ 250GBSATA disks running in linux raid1,
linux raid0 and linux LVM2

Boots and runs without problem with 2.6.15-rc5-git1,

Applying this patch lets it boot, but I cant login either locally or with
ssh, no output on VT12 or in the logs, but the hd led is lit all the
time...

only way to reboot is the reset button...


Distribution is Mandriva Linux 2006 x86_64, gcc 4.0.1

attached are config and /var/log/messages parts that got logged

--
Regards

Thomas
