From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: AIC 8110
Date: Wed, 19 Jan 2005 20:34:33 +0100
Message-ID: <58cb370e050119113410ce3baf@mail.gmail.com>
References: <Pine.LNX.4.44.0501192013300.14873-100000@kenzo.iwr.uni-heidelberg.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:25526 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261862AbVASTek (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jan 2005 14:34:40 -0500
Received: by wproxy.gmail.com with SMTP id 67so11323wri
        for <linux-ide@vger.kernel.org>; Wed, 19 Jan 2005 11:34:33 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44.0501192013300.14873-100000@kenzo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org

On Wed, 19 Jan 2005 20:24:56 +0100 (CET), Bogdan Costescu
<Bogdan.Costescu@iwr.uni-heidelberg.de> wrote:
> 
> Hi!

Hi Bogdan,
 
> Does anyone has some information about Adaptec's AIC 8110 SATA adapter ?
> 
> I can see it used on mainboards like Asus PSCH-SR/SATA, but I couldn't
> find any information about Linux support. One of the Google searches
> returned a hit suggesting that it's just a rebranded Silicon Image
> chip, but without specifying which chip...

Since it is 4xSATA controller I bet that it is based on SiL3114.
You can add the PCI ID to drivers/scsi/sata_sil.c and give it a go...
 
Bartlomiej
