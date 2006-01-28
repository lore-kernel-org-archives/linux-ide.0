From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/12] libata: implement ata_drive_probe_reset()
Date: Fri, 27 Jan 2006 20:58:45 -0500
Message-ID: <43DACFD5.6020507@pobox.com>
References: <11380899221448-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:16068 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422788AbWA1B6w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2006 20:58:52 -0500
In-Reply-To: <11380899221448-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Most low level drivers share supported reset/classify actions and
> sequence.  This patch implements ata_drive_probe_reset() which helps
> constructing ->probe_reset from three component operations -
> softreset, hardreset and postreset.  This minimizes duplicate code and
> yet allows flexibility if needed. The three component operations can
> also be shared by EH later.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


