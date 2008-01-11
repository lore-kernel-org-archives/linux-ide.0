From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Fri, 11 Jan 2008 16:51:14 -0500
Message-ID: <87f94c370801111351g132674fam295ba82a78f17842@mail.gmail.com>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
	 <20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111149x15afd429sf48ed7db5fff8fa1@mail.gmail.com>
	 <20080111195521.7e771e45@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111227x50c9ff31n1435d005e6b6b1f3@mail.gmail.com>
	 <20080111210557.390271a0@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111327m1363b681ree81fbc5f7f43848@mail.gmail.com>
	 <20080111213415.56d90f0d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:47944 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761755AbYAKVvP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 16:51:15 -0500
Received: by wx-out-0506.google.com with SMTP id h31so842260wxd.4
        for <linux-ide@vger.kernel.org>; Fri, 11 Jan 2008 13:51:14 -0800 (PST)
In-Reply-To: <20080111213415.56d90f0d@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kristin Vadas Marsicano <kristin.marsicano@gmail.com>, linux-ide@vger.kernel.org

On Jan 11, 2008 4:34 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > most of the machines I encounter  (and with both SATA and IDE drives),
> > except for the Dell D610 and HP 7700 (small desktop pc).  The models I
> > just mentioned run the shred really slow, which I believe is due to
> > the DMA problem I was having (outlined in my previous emails).  Any
> > thoughts?
>
> If your shred program is relying on DMA then you are using the wrong tool
> for the job. The correct way to erase a disk is to send it a security
> erase command. Rewriting over the data may not do what is wanted.

Alan,

I was talking to Kristin this morning about doing that.  I was
concerned that there is not anybody certifying that each individual
disk drive model / firmware release is properly implementing the
Security Erase function.

Are you aware of testing body, etc. that publishes a white-list of
drives that are known to have a proper implementation of Security
Erase?  Lacking something like that and realizing how rarely it is
used, I'm not sure it should be trusted.

Performing both a Security Erase and calling shred on the drive might
be the ultimate one-two punch.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
