From: Jarrod Johnson <jarrod.b.johnson@gmail.com>
Subject: Re: Problems w/ RAID-5/sata_promise/PDC20579
Date: Thu, 21 Jul 2005 21:23:54 -0400
Message-ID: <fab4e42a0507211823236da64b@mail.gmail.com>
References: <fab4e42a050718215857958bc4@mail.gmail.com>
Reply-To: Jarrod Johnson <jarrod.b.johnson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:53961 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261973AbVGVBYb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jul 2005 21:24:31 -0400
Received: by wproxy.gmail.com with SMTP id i11so190282wra
        for <linux-ide@vger.kernel.org>; Thu, 21 Jul 2005 18:24:30 -0700 (PDT)
In-Reply-To: <fab4e42a050718215857958bc4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Has anyone had success with any SATAII sata_promise card doing large
amounts of I/O to multiple drives attached to a controller?  If can
resync ~20 GB arrays with relatively low risk, but if trying to
sustain a resync/restore over 200 GB or so, I rarely complete,
especially if booted and doing typical multi-user stuff.  During
normal operation of a synced raid-5 array, the controller hoses up
every few days in the same manner by simple matter of probablity I
suppose.

Is there anything I can do to help get this fixed?  Or is the solution
possibly elsewhere?  Is there libata work done recently for SATAII in
general?

On 7/19/05, Jarrod Johnson <jarrod.b.johnson@gmail.com> wrote:
> I have a Soltek planar with this controller providing two ports.
> 
> As I try to use those ports together with two non-pdc attached sata
> drives for software raid, the devices hanging off of the PDC
> controller frequently become unresponive, throwing I/O errors on every
> attempt to read a sector after a timeout.
> 
> Don't have the exact error in front of me, but essentially, it gets
> command timeout,
> then every command to the controller seems to give the same, status of
> 0xff busy, but not much more informative output.
> 
> The situation seems very similar to Jim Ramsays:
> http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/1671725.html
> 
> Output seems to line up pretty much exactly, except specific sector
> numbers, of course.
>
