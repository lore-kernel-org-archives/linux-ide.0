From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.18-rc4-mm2
Date: Sun, 20 Aug 2006 15:30:30 +0200
Message-ID: <6bffcb0e0608200630h40d2b07v1db22d19753734be@mail.gmail.com>
References: <20060819220008.843d2f64.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:30608 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750773AbWHTNab (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Aug 2006 09:30:31 -0400
Received: by py-out-1112.google.com with SMTP id n25so2003807pyg
        for <linux-ide@vger.kernel.org>; Sun, 20 Aug 2006 06:30:31 -0700 (PDT)
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 20/08/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
>

0kB Cache?

hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)

It should be 2048kB

Aug 20 14:28:07 euridica kernel: hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW
drive, 2048kB Cache, UDMA(33)
Aug 20 14:28:07 euridica kernel: Uniform CD-ROM driver Revision: 3.20
Aug 20 14:28:07 euridica kernel: hdd: ATAPI 52X CD-ROM CD-R/RW drive,
2048kB Cache, UDMA(33)

config & dmesg -> http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm2/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
