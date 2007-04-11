From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci.c: remove non-existing SB600 raid id
Date: Wed, 11 Apr 2007 19:00:17 +0900
Message-ID: <461CB1B1.9030207@gmail.com>
References: <5767b9100704110254s16566ce7n147aa578181d84e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751943AbXDKKAY@vger.kernel.org>
In-Reply-To: <5767b9100704110254s16566ce7n147aa578181d84e6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Conke Hu <conke.hu@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Conke Hu wrote:
>    SB600 RAID and SB600 SATA is the same controller and share the
> same PCI ID 0x4380. There is such PCI ID 0x4381.

I assume 'no' is missing in the last sentence.  :-)

-- 
tejun
