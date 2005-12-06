From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: [PATCH] sata_sil: greatly improve DMA handling
Date: Tue, 6 Dec 2005 13:41:02 +0200
Message-ID: <200512061341.02863.tmb@mandriva.org>
References: <20051203200438.GA3770@havoc.gtf.org> <dn297e$aip$1@sea.gmane.org> <439554A3.7000305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964953AbVLFLlF@vger.kernel.org>
In-Reply-To: <439554A3.7000305@pobox.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

tisdag 06 december 2005 11:06 skrev Jeff Garzik:
> Thomas Backlund wrote:
> > Jeff Garzik wrote:
> >>To make it easy for others to test, since there are merge conflicts,
> >>I've combined the two previous sata_sil patches into a single patch.
> >>
> >>Verified here on my 3112 (Adaptec 1210SA).
> >>
> >>I'm especially interested to hear from anyone willing to test on a
> >>SI 3114 (4-port).
> >
> > Please cc me as I'm not subscribed....
> >
> >
> > ASUS K8N-E-Deluxe, nForce3 250Gb chipset, AMD Athlon64 3200+ running
> > x86_64
> >
> > Sil 3114A with 3 Maxtor MaxLine III+ 250GBSATA disks running in linux
> > raid1, linux raid0 and linux LVM2
> >
> > Boots and runs without problem with 2.6.15-rc5-git1,
> >
> > Applying this patch lets it boot, but I cant login either locally or with
> > ssh, no output on VT12 or in the logs, but the hd led is lit all the
> > time...
>
> Thanks for testing.
>
> > only way to reboot is the reset button...
> >
> >
> > Distribution is Mandriva Linux 2006 x86_64, gcc 4.0.1
> >
> > attached are config and /var/log/messages parts that got logged
>
> Didn't receive any attachments...
>
> 	Jeff


And just to add...
as you can see from the messages file the kernel is capable of writing logging 
of the whole bootup to the disks, but it stopped logging pretty much directly 
as the kernel was fully started...

Any more tests you want?? more debugging enabled? or what?...
--
Regards

Thomas
