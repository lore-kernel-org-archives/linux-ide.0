From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Setting up Silicon image 3114 in DMA mode
Date: Wed, 30 Jun 2010 20:33:07 -0400
Message-ID: <4C2BE243.5040308@garzik.org>
References: <AANLkTinYuxwsLQKGRd6joRSCcbnns930DDienlhfEB8i@mail.gmail.com> <4C257E67.9090101@gmail.com> <AANLkTikeQO1v-ag_DDbkgxoZRTk1_fomn1kbHKqH9vkD@mail.gmail.com> <AANLkTimOu5GfUN848EOiMIZONHrRjgYyexmwBL3OCAMs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61529 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab0GAAdO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2010 20:33:14 -0400
In-Reply-To: <AANLkTimOu5GfUN848EOiMIZONHrRjgYyexmwBL3OCAMs@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: amruth pattanada <amruth.vamadev@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 06/30/2010 08:30 AM, amruth pattanada wrote:
> Hi
> I need some clarification regarding read DMA data from silicon image
> controller. How do know that DMA transfer happened and where to look
> for the data after the transfer. Should we look at BAR2 channel X Task
> file register data word or look into allocated DMA buffer which is
> specified in the PRD table. I am reading 0x00 in the PRD table scatter
> gather list and it hangs in the when I tried to read data word of
> channel task file register. Please let me know how to read data buffer
> after the DMA is complete.

Teaching you how to write a non-Linux driver is outside the scope of 
linux-ide and linux-kernel.  This information is covered by the freely 
available Silicon Image documentation, and SiI support should be able to 
assist you further beyond that.

	Jeff



