From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Date: Wed, 30 Mar 2005 14:06:37 +0200
Message-ID: <58cb370e05033004065b14da51@mail.gmail.com>
References: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:2527 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261854AbVC3MGk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2005 07:06:40 -0500
Received: by wproxy.gmail.com with SMTP id 68so129954wra
        for <linux-ide@vger.kernel.org>; Wed, 30 Mar 2005 04:06:40 -0800 (PST)
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 30 Mar 2005 13:52:05 +0200, kus Kusche Klaus <kus@keba.com> wrote:

> However, things break seriously when exercising the CF card in parallel
> (e.g. with a dd if=/dev/hda of=/dev/null):
> 
> * The rtc *interrupt handler* is delayed for up to 250 *micro*seconds.
> This is very bad for my purpose, but easy to explain: It is roughly the
> time needed to transfer 512 Bytes from a CF card which can transfer 2
> Mbyte/sec, and obviously, the CPU blocks all interrupts while making pio
> 
> transfers. (Why? Is this really necessary?)
>  
> (I know because I instrumented the rtc irq handler with rdtscl(), too)

hdparm -u1 /dev/hda

should help
