From: Tejun Heo <tj@kernel.org>
Subject: Re: port multiplier problem
Date: Tue, 02 Feb 2010 23:24:01 +0900
Message-ID: <4B683581.7070708@kernel.org>
References: <4B5885F7.2020007@gmail.com> <4B679EA9.6030203@kernel.org> <4B6833DD.1020001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39710 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756052Ab0BBOVf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Feb 2010 09:21:35 -0500
In-Reply-To: <4B6833DD.1020001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chandra Shekhar Sah <edu4madh@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 02/02/2010 11:17 PM, Chandra Shekhar Sah wrote:
> I thought PMP is damaged so I purchased a new NORCO-LIB1220 backplane
> card but same problem. The disks connected to PMP are not being
> recognized. However, disk connected to "direct sata" (no disks on PMP)
> is fine.

Ah.. okay, can you please post full dmesg of failed probe?

Thanks.

-- 
tejun
