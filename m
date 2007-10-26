From: "David Gaarenstroom" <david.gaarenstroom@gmail.com>
Subject: Re: [PATCH 5/5]: [PCI]: Remove 3 incorrect MSI quirks.
Date: Fri, 26 Oct 2007 12:56:52 +0200
Message-ID: <9783dadb0710260356g4ef94e3dvadf69d4d263c2361@mail.gmail.com>
References: <20071025.011716.123998434.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:54706 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbXJZK4y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 06:56:54 -0400
Received: by nz-out-0506.google.com with SMTP id s18so783097nze
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 03:56:53 -0700 (PDT)
In-Reply-To: <20071025.011716.123998434.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com

2007/10/25, David Miller <davem@davemloft.net>:
>
> Now that we have dealt with the real issue, in that some ATI SATA and
> USB controllers needed the INTX_DISABLE quirk, we can remove these AMD
> chipset global MSI disabling quirks.

IMHO we should remove *all* former ATI "AMD" chipset global MSI
disabling quirks... The whole idea was to sort things out once and for
all. At least the RS480 quirk can be removed, now that the USB driver
has the workaround for the SB400 southbridge USB. I suspect the same
counts for the other ATI chipsets...

To quote Greg K-H:
"But for now, let's not take a band-aid that prevents others from
working to solve the real issues here."
