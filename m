From: "Eric A. Cottrell" <eac@shore.net>
Subject: Re: [PATCH 2.6.12-rc2 0/2] libata: add reporting of atapi errors
Date: Sat, 16 Apr 2005 21:54:40 -0400
Message-ID: <4261C1E0.7050200@shore.net>
References: <425A49F6.3040904@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.primushost.com ([209.58.220.66]:7895 "EHLO
	smtp2.primushost.com") by vger.kernel.org with ESMTP
	id S261238AbVDQByr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Apr 2005 21:54:47 -0400
In-Reply-To: <425A49F6.3040904@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Hello Jeff,

Simple ATAPI error reporting for your review.

Description:
Patch 1/2 is a simple fix to add a missing read of the error register when the task file is read.
Patch 2/2 reads the error register if there is an error on a ATAPI device and builds a simple SCSI sense block.

73 Eric  eac@shore.net
