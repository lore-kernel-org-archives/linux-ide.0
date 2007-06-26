From: "Matthew \"Cheetah\" Gabeler-Lee" <cheetah-lkmlsata@fastcat.org>
Subject: Re: Frequent SATA resets with sata_nv (fwd)
Date: Tue, 26 Jun 2007 12:06:37 -0400 (EDT)
Message-ID: <alpine.DEB.0.99.0706251207230.20899@cheetah.fastcat.org>
References: <fa.Z5bo5y2TvW4efa6slAJpcdPwqAA@ifi.uio.no>
 <467ECBB8.2030706@shaw.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758136AbXFZQGv@vger.kernel.org>
In-Reply-To: <467ECBB8.2030706@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sun, 24 Jun 2007, Robert Hancock wrote:

> Matthew "Cheetah" Gabeler-Lee wrote:
> > (Please cc me on replies)
> > 
> > I have three samsung hdds (/sys/block/sda/device/model says SAMSUNG SP2504C)
> > in a raid configuration.  My system frequently (2-3x/day) experiences
> > temporary lockups, which produce messages as below in my dmesg/syslog.  The
> > system recovers, but the hang is annoying to say the least.
> 
> Does this drive actually support NCQ? I can't tell from this part of the  log.

I selected that model in part because it at least claimed to support 
NCQ.  I'm not sure if it reflects NCQ or not, but I do have 
/sys/block/sd[abc]/device/queue_{depth,type} which show simple and 31 
respectively.  Samsung's page for the drive also says it supports NCQ: 
http://www.samsung.com/Products/HardDiskDrive/SpinPointPSeries/HardDiskDrive_SpinPointPSeries_SP2504C.htm

-- 
	-Cheetah
"Reality is that which, when you stop believing in it, doesn't go away".
                -- Philip K. Dick
GPG pubkey fingerprint: A57F B354 FD30 A502 795B 9637 3EF1 3F22 A85E 2AD1
