From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: About forcing 32bit DMA patch for AMD690G(SB600)
Date: Thu, 31 Jan 2008 16:53:10 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E5020F102@sshaexmb1.amd.com>
References: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com>
 <47992BA3.3070104@gmail.com>
 <76366b180801242019h382fd604vd1458dab8b64dd4c@mail.gmail.com>
 <4799788E.1030600@gmail.com>
 <76366b180801251707j7b892d6w83fcf3560426aa19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:60797 "EHLO
	outbound4-wa4-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754020AbYAaI5Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jan 2008 03:57:24 -0500
Content-class: urn:content-classes:message
In-Reply-To: <76366b180801251707j7b892d6w83fcf3560426aa19@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>, Tejun Heo <htejun@gmail.com>
Cc: sriharivijayaraghavan@yahoo.com.au, linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

Hi Andrew:

Thanks for your help on your platform.
And Is there any update at your side on SB600 64bit DMA capacity?

As Tejun mentioned, the test result on my SB600 engineering board
(RS690 A12 +SB600 A21) is a little different from the result of Srihari.
But I do not have other SB600 boards especially ASUS M2A-VM to do
further debug. So if you can provide us your test result, that's really
good.


Thanks
Shane



> -----Original Message-----
> From: andrew.m.paprocki@gmail.com 
> [mailto:andrew.m.paprocki@gmail.com] On Behalf Of Andrew Paprocki
> Sent: Saturday, January 26, 2008 9:08 AM
> To: Tejun Heo
> Cc: Shane Huang; sriharivijayaraghavan@yahoo.com.au; 
> linux-ide@vger.kernel.org
> Subject: Re: About forcing 32bit DMA patch for AMD690G(SB600)
> 
> I'll try to get that configuration together.. right now I only have 2
> 1gb sticks installed on the board, so I would need to track down 2gb
> ones. If I can find some laying around, I'll let you know.
> 
> Thanks,
> -Andrew
> 
> On Jan 25, 2008 12:50 AM, Tejun Heo <htejun@gmail.com> wrote:
> > Andrew Paprocki wrote:
> > > I have an SB600/RS690 here with SATA drives connected. I 
> haven't been
> > > following this thread, but I can help test something if 
> it would help.
> >
> > We're trying to determine whether SB600 ahci controller can 
> do 64bit DMA
> > or not.  Srihari's couldn't but Shane's test result tells a 
> different
> > story.  Do you have memory mapped over 4G (if you have 4G 
> some of them
> > will be over 4G, you can know this by looking at the e820 
> map printed
> > during boot)?


