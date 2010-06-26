From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Setting up Silicon image 3114 in DMA mode
Date: Fri, 25 Jun 2010 22:13:27 -0600
Message-ID: <4C257E67.9090101@gmail.com>
References: <AANLkTinYuxwsLQKGRd6joRSCcbnns930DDienlhfEB8i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43153 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0FZEN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jun 2010 00:13:29 -0400
In-Reply-To: <AANLkTinYuxwsLQKGRd6joRSCcbnns930DDienlhfEB8i@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: amruth pattanada <amruth.vamadev@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 06/25/2010 02:25 AM, amruth pattanada wrote:
> Hi
> Can anybody please guide me what minimal steps to follow for setting
> up 3114 for operating in DMA mode and looked into linux 2.6.32.7 code.
> I am porting 3114 driver to RTOS but have problems in using BAR5 PCI
> config space because of Memory mapped region issues. I can access BAR4
> and plan to set up DMA mode.
> How do we access entire BAR5 memory space without using BAR5, is there
> any indirect way to access BAR5 using BAR4. Please let me know.
> Thanks
> Amruth p.v
> Sr.Embedded Engineer

See the datasheet (PCI Configuration Space section), there's a way to 
access BAR5 registers using indirect access registers in configuration 
space. I expect this will be relatively slow, however.
