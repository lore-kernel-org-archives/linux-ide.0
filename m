From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v1] sata_mv: conversion to new EH
Date: Fri, 26 Jan 2007 02:48:51 -0500
Message-ID: <45B9B263.8060409@garzik.org>
References: <20070126070632.GA17323@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43464 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030786AbXAZHsx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jan 2007 02:48:53 -0500
In-Reply-To: <20070126070632.GA17323@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> This is the first cut at converting sata_mv to new EH.
> 
> It builds, but is untested.
> 
> Done:
> - freeze, thaw
> - hardreset
> - prereset, software: intentionally not implemented

s/software/softreset/

