From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Tue, 5 Apr 2005 23:41:05 +0200
Message-ID: <58cb370e05040514417610ad0e@mail.gmail.com>
References: <7A8F92187EF7A249BF847F1BF4903C04010EEAFA@ausx2kmpc103.aus.amer.dell.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:38000 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262054AbVDEVlQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Apr 2005 17:41:16 -0400
Received: by wproxy.gmail.com with SMTP id 68so592596wra
        for <linux-ide@vger.kernel.org>; Tue, 05 Apr 2005 14:41:11 -0700 (PDT)
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C04010EEAFA@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Stuart_Hayes@dell.com" <Stuart_Hayes@dell.com>
Cc: linux-ide@vger.kernel.org

On Apr 5, 2005 11:08 PM, Stuart_Hayes@dell.com <Stuart_Hayes@dell.com> wrote:

> How is this?  I already had the "flags" declarations at the beginning of
> the functions, but I wrapped them and the irq disable/enables in the

I mean at the very beginning but lets leave it as it is.

> HIGHMEM ifdef, like ide_pio_sector() in ide-taskfile.c.

thanks

Bartlomiej
