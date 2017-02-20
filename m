From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] pata: remove the at91 driver
Date: Mon, 20 Feb 2017 18:28:05 +0100
Message-ID: <c0566bd6-f1e5-8508-d9fb-19a938018322@microchip.com>
References: <CGME20170217093732epcas5p463c32b21e7c71000d01d15c54333c1f6@epcas5p4.samsung.com>
 <1487324200-17517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1599704.hbkP4KrUDJ@amdc3058> <20170217144235.1fd12c80@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170217144235.1fd12c80@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Le 17/02/2017 à 14:42, Boris Brezillon a écrit :
> On Fri, 17 Feb 2017 13:36:08 +0100
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:
> 
>> Hi,
>>
>> On Friday, February 17, 2017 10:36:40 AM Boris Brezillon wrote:
>>> This driver is orphan since commit 2e591e7b3ac2 ("ARM: at91: remove
>>> at91sam9261/at91sam9g10 legacy board support"). Given that nobody cared
>>> adding DT support to it, it probably means it's no longer used and is
>>> thus a good candidate for removal.  
>>
>> The exact commit which removed PATA support for AT91SAM9260 seems to
>> be b2026f708e09 ("ARM: at91: remove at91sam9260/at91sam9g20 legacy
>> board support").
> 
> Indeed. I'll fix the commit message and send a new version.
> 
>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>  
>>
>> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>


-- 
Nicolas Ferre
