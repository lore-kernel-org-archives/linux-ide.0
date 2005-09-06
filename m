From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Make ide-cs work for hardware with 8-bit CF-Interface
Date: Wed, 07 Sep 2005 00:30:31 +0100
Message-ID: <1126049432.29122.6.camel@localhost.localdomain>
References: <431DC80C.8030706@maintech.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932169AbVIGPUd@vger.kernel.org>
In-Reply-To: <431DC80C.8030706@maintech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Thomas Kleffel (LKML)" <lkml@maintech.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-09-06 at 18:47 +0200, Thomas Kleffel (LKML) wrote:
> According to the specs, those registers should be there in every CF 
> card. I've tested this with a couple of CFs, including SanDisk, 
> Microdrive and several NoNames.

ide-cs handles a lot more than just CF cards so it might not be a wise
approach fpr general consumption.
