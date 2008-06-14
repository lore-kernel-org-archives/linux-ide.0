From: "dunneil" <dunneil@live.cn>
Subject: Re: ahci.c
Date: Sat, 14 Jun 2008 22:08:41 +0800
Message-ID: <BAY122-DS68D2239CEA46CE01EB158BEAF0@phx.gbl>
References: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay0-omc2-s19.bay0.hotmail.com ([65.54.246.155]:58068 "EHLO
	bay0-omc2-s19.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754730AbYFNOK2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jun 2008 10:10:28 -0400
In-Reply-To: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

The ASATA Controller BAR0~BAR4 must be alloccated IO bar,BAR5 must be 
allocated Memory BAR?

The Bar0~4 IO Bar is option or necessary?

--------------------------------------------------
From: "Jeff Garzik" <jgarzik@pobox.com>
Sent: Friday, June 13, 2008 4:49 PM
To: "dunneil" <dunneil@live.cn>
Cc: <linux-ide@vger.kernel.org>
Subject: Re: ahci.c

> dunneil wrote:
>> if there are two ASATA controller inside motherboard, it will cause
>> conflict
>> for BUS Master Enable bit? Do i need disable the motherboard integrated
>> ASATA controoller for my separate ASATA controller FPGA board?
>
> You can have as many AHCI PCI devices as you wish.
>
> Each PCI device has its own Bus Master Enable bit in the PCI Command
> register.
>
> Jeff
>
>
>
> 
