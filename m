From: Mark Lord <mlord@pobox.com>
Subject: Re: sata_mv WARNING: at drivers/ata/libata-sff.c:1322
Date: Thu, 14 Jul 2011 08:03:41 -0400
Message-ID: <4E1EDB1D.1060906@pobox.com>
References: <20110626070820.GC24867@merlins.org>
 <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com>
 <20110629034125.GC32153@merlins.org> <4E0AA1C1.6020406@pobox.com>
 <20110629050341.GB10580@merlins.org> <20110629150713.GG10580@merlins.org>
 <4E0B4CC7.5000601@pobox.com> <20110712142938.GB4347@mtj.dyndns.org>
 <CAMHSBOWrU0MRuDOvAsU-=hqZnZrRp2ry6zvYTH0M8kwXfopryQ@mail.gmail.com>
 <4E1E1F12.8040100@pobox.com>
 <CAMHSBOU+XHaFn_HtDTdvPr-sHEGS9MsYgCG9dUk71hLZJDaRow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab1GNMDo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jul 2011 08:03:44 -0400
In-Reply-To: <CAMHSBOU+XHaFn_HtDTdvPr-sHEGS9MsYgCG9dUk71hLZJDaRow@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Tejun Heo <tj@kernel.org>, Marc MERLIN <marc@merlins.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

On 11-07-14 03:19 AM, Gwendal Grignou wrote:
> Mark,
> 
> How PMP support with sata_mv broken for you? I am using marvell 7042
> and sil3726 and it works fine, but I am still using 2.6.36.


It's broken when used with a Marvell PMP.
Still works with other brands.

Strange, that.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
