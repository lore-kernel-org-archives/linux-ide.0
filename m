From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.13-rc6 ] (updated) serverworks: Add support for new southbridge IDE
Date: Wed, 17 Aug 2005 21:14:02 +0200
Message-ID: <58cb370e050817121429c384bc@mail.gmail.com>
References: <8AFFB74283C8EF46ACA4C331087033F10F5BCB@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.197]:22296 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751202AbVHQTOE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Aug 2005 15:14:04 -0400
Received: by nproxy.gmail.com with SMTP id x37so70087nfc
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2005 12:14:02 -0700 (PDT)
In-Reply-To: <8AFFB74283C8EF46ACA4C331087033F10F5BCB@NT-SJCA-0750.brcm.ad.broadcom.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Naren (Narendra) Sankar" <nsankar@broadcom.com>
Cc: linux-ide@vger.kernel.org

On 8/17/05, Naren (Narendra) Sankar <nsankar@broadcom.com> wrote:
> Hi Everyone

Hi,

> Description -
> 
> BCM5785 (HT1000) is a Opteron Southbridge from Serverworks/Broadcom that
> Incorporates a single channel ATA100 IDE controller that is functionally
> Identical to the Serverworks CSB6 IDE controller. This patch adds support For
> the new PCI device ID and also the support for this controller.

Patch looks fine but don't you need to also add HT1000 ID to swvks_csb_check()?

Bartlomiej
