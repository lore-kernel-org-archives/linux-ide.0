From: "Carlos Vidal" <carlos@tarkus.se>
Subject: Re: SiI 3124 PCI-X
Date: Tue, 24 Oct 2006 23:55:05 +0200
Message-ID: <9dccd9b80610241455v792f0f9cwa5e1efdb6e1dda04@mail.gmail.com>
References: <9dccd9b80610231240m876e3b3kc15ac80288645a93@mail.gmail.com>
	 <453D4631.3030009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:21708 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422689AbWJXVzI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Oct 2006 17:55:08 -0400
Received: by ug-out-1314.google.com with SMTP id 32so342471ugm
        for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 14:55:07 -0700 (PDT)
In-Reply-To: <453D4631.3030009@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun:

Thank you for your help. I included your patch in the FC5 latest
kernel update and it works very well.

I'm just finishing the RAID-5 reconstruction of 3x750GB disks, so they
are all visible and working stable.

If anybody is interested, this is the method I used:

- Kernel 2.6.18-1.2200_FC5 is actually 2.6.18.1 with a number of
paches added by the Fedora team.
- The RPM builds the kernel from 2.6.18, then applies the patch to
move to 2.6.18.1, and then the Fedora patches.
- I applied your patch just after the 2.6.18.1 patch and then slightly
modified the spec file to skip a couple of patches that conflicts with
yours.

If anybody wants a more detailed procedure I will be happy to provide it.

Thank you Tejun!

Carlos

On 10/24/06, Tejun Heo <htejun@gmail.com> wrote:
> Carlos Vidal wrote:
> > Hi Tejun:
> >
> > First, thank you for your work with the SATA drivers!
> >
> > I have a Stardom SATA-II PCI-X card and 3 hard disks connected with a
> > Stardom SOHOTank. According to the documentation, the SOHOTank uses
> > SATA multiport and sata_sil24 should recognize all disks
> > automatically.
> >
> > Unfortunatelly, when I load the driver only one disk is seen (the
> > second one, weirdly).
> >
> > I'm using FC5 with kernel 2.6.18-1.2200.fc5. In principle this
> > corresponds to your 2.6.17 patch (when I try to apply it it says it is
> > already there).
> >
> > Is there any special thing I need to do to activate multi-port
> > recognition? I'm wondering if there is an option, something in /sys or
> > /proc, or a special BIOS flash for the card.
> >
> > Any clues are very welcome! :-)
>
> Hello,
>
> Being a long-time debian user, I dunno anything about the -FC kernel.
> Does it actually contain PMP support?  The behavior you're describing
> matches libata's behavior w/o PMP support.  Please give a shot at
> vanilla 2.6.18.1 + libata-tj-2.6.18.1-20061020.  The patch is available
> in the following page.
>
> http://home-tj.org/wiki/index.php/Libata-tj-stable
>
> Also, please cc linux-ide@vger.kernel.org next time so that other people
> can answer and the thread can be searched later.
>
> --
> tejun
>
