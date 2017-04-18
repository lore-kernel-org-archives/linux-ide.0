From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ide: don't call memcpy with the same source and destination
Date: Tue, 18 Apr 2017 12:58:27 +0200
Message-ID: <3967489.2j6es1sVNT@amdc3058>
References: <alpine.LRH.2.02.1704141433280.10706@file01.intranet.prod.int.rdu2.redhat.com>
 <CGME20170418105834epcas1p1b000622da41db1214d1a9a1b888f7896@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-reply-to: <alpine.LRH.2.02.1704141433280.10706@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Friday, April 14, 2017 02:35:33 PM Mikulas Patocka wrote:
> The parisc architecture recently reimplemented the memcpy function and
> their reimplementation crashed when source and destination overlapped.
> 
> The crash happened in the function ide_complete_cmd where memcpy is called
> with the same source and destination pointer. According to the C
> specification, memcpy behavior is undefined if the source and destination
> range overlaps. This patches fixes the undefined behavior.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

