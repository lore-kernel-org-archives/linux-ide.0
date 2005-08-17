From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.13-rc6 ] (updated) serverworks: Add support for new southbridge IDE
Date: Wed, 17 Aug 2005 21:55:42 +0200
Message-ID: <58cb370e0508171255219283f2@mail.gmail.com>
References: <8AFFB74283C8EF46ACA4C331087033F10F5C07@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.192]:38313 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751233AbVHQTzq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Aug 2005 15:55:46 -0400
Received: by nproxy.gmail.com with SMTP id x37so71701nfc
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2005 12:55:42 -0700 (PDT)
In-Reply-To: <8AFFB74283C8EF46ACA4C331087033F10F5C07@NT-SJCA-0750.brcm.ad.broadcom.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Naren (Narendra) Sankar" <nsankar@broadcom.com>
Cc: linux-ide@vger.kernel.org

On 8/17/05, Naren (Narendra) Sankar <nsankar@broadcom.com> wrote:
> It is added to svwks_csb_check -
> 
> 
> @@ -109,6 +114,7 @@ static u8 svwks_csb_check (struct pci_de
>                 case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
>                 case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE:
>                 case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2:
> +               case PCI_DEVICE_ID_SERVERWORKS_HT1000IDE:
>                         return 1;
>                 default:
>                         break;
> 

Indeed, I need some rest... :-)

ACK

Thanks,
Bartlomiej
