From: sean darcy <seandarcy2@gmail.com>
Subject: Re: does AHCI work on intel 915 ICH6 controllers? Is it supposed to?
Date: Sat, 18 Jun 2005 16:21:58 -0400
Message-ID: <c195ebf705061813215c5200a8@mail.gmail.com>
References: <d87q4j$d37$1@sea.gmane.org> <42A7A191.7040700@pobox.com>
	 <d89hcm$7ej$1@sea.gmane.org> <42AD0305.5060705@tw.ibm.com>
Reply-To: sean darcy <seandarcy2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:29687 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262250AbVFRUV7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Jun 2005 16:21:59 -0400
Received: by wproxy.gmail.com with SMTP id 68so160807wri
        for <linux-ide@vger.kernel.org>; Sat, 18 Jun 2005 13:21:58 -0700 (PDT)
In-Reply-To: <42AD0305.5060705@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 6/18/05, sean darcy <seandarcy2@gmail.com> wrote:
> On 6/12/05, Albert Lee <albertcc@tw.ibm.com> wrote:
> [........]
> > >
> >
> > Hi Sean,
> >
> > I also have a 915G based system (AOpen EZ915) and I'm interested to try the
> > AHCI support. So I checked whether AHCI could be used on my 915G box.
> > The PCI device ID for my ICH6 is 0x2651.
> > => So, no AHCI support. :(
> > (Only ICH6-R 0x2652 and ICH6-M 0x2653 have AHCI support. Not plain ICH6.
> > http://download.intel.com/design/chipsets/specupdt/30147411.pdf )
> >
> Mine is also 0x2651.
>
> But I must be blind, but I don't see any statement that  only  -R and
> -M have AHCI support.
>
> sean
>

In fact, look at 12.1.15 in
http://developer.intel.com/design/chipsets/datashts/30147302.pdf.

Maybe the driver ( BIOS? ) is not setting the SCRAE bit, whatever the
hxxx that is!

sean
