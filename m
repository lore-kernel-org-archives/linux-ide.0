From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Tue, 5 Apr 2005 22:27:36 +0200
Message-ID: <58cb370e0504051327751a19d8@mail.gmail.com>
References: <7A8F92187EF7A249BF847F1BF4903C04010EEAF7@ausx2kmpc103.aus.amer.dell.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.192]:64726 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262006AbVDEU1j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Apr 2005 16:27:39 -0400
Received: by wproxy.gmail.com with SMTP id 68so565357wra
        for <linux-ide@vger.kernel.org>; Tue, 05 Apr 2005 13:27:39 -0700 (PDT)
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C04010EEAF7@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Stuart_Hayes@dell.com" <Stuart_Hayes@dell.com>
Cc: linux-ide@vger.kernel.org

Hi,

On Apr 5, 2005 9:12 PM, Stuart_Hayes@dell.com <Stuart_Hayes@dell.com> wrote:
> 
> The system can panic with a null pointer dereference using ide-scsi if
> PIO is being done on scatter gather pages that are in high memory,
> because page_address() returns 0.  We are actually seeing this using a
> tape drive.  This patch will kmap_atomic() the pages before performing
> PIO.
> 
> I'm copying the text here, but I'm also attaching it as a file, because
> the text will get garbled with extra line breaks.
> 
> Please let me know if there are any problems with the patch!

Looks fine, I have two small requests:
* please don't disable/enable local IRQs for !HIGHMEM case
  (see ide_pio_sector() in ide-taskfile.c)
* declare 'unsigned long flags' at the beginning of the function

> (I sent this patch to linux-scsi a few weeks ago, and I was finally told
> that it is maintained by the IDE folks (Bartlomiej Zolnierkiewicz), not
> the SCSI folks...)

I'm not on linux-scsi, *sigh*, somebody could have simply 
forwarded it to me...

Thanks!
Bartlomiej
