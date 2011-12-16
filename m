From: Mark Lord <kernel@teksavvy.com>
Subject: Re: How does libata handles an 'ATA_ABORTED' error?
Date: Thu, 15 Dec 2011 23:26:04 -0500
Message-ID: <4EEAC85C.1080501@teksavvy.com>
References: <201112140948.03859.jbe@pengutronix.de> <4EE98AF4.7090509@gmail.com> <201112151201.15044.jbe@pengutronix.de> <CADLC3L2MbPsoDuEMHeOiitU_NvARasKgaBCxdijgX=F744XyGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:36424 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754042Ab1LPE0G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Dec 2011 23:26:06 -0500
In-Reply-To: <CADLC3L2MbPsoDuEMHeOiitU_NvARasKgaBCxdijgX=F744XyGA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Juergen Beisert <jbe@pengutronix.de>, linux-ide@vger.kernel.org

On 11-12-15 01:38 PM, Robert Hancock wrote:
> On Thu, Dec 15, 2011 at 5:01 AM, Juergen Beisert <jbe@pengutronix.de> wrote:
..
>> As far as I understand the problem of this kind of errors is for the multi
>> sector write case. The framework does not know what sectors fails, so the
>> question is: does it repeat the whole multi sector sequence or what else it
>> does?
> 
> The entire request should get retried.

I'm not so sure that is correct.

The Linux IDE stack will not retry the completed sectors
(those which were successfully transfered in multiple-sector blocks).

Not sure what libata does here.

Cheers
