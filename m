From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/5] libata: improve EH retry delay handling
Date: Mon, 19 May 2008 19:33:11 +0100
Message-ID: <20080519193311.01b5b928@core>
References: <12112174741373-git-send-email-htejun@gmail.com>
	<1211217475951-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56134 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751188AbYESSpM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 14:45:12 -0400
In-Reply-To: <1211217475951-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, Tejun Heo <htejun@gmail.com>

On Tue, 20 May 2008 02:17:52 +0900
Tejun Heo <htejun@gmail.com> wrote:

> EH retries were delayed by 5 seconds to ensure that resets don't occur
> back-to-back.  However, this 5 second delay is superflous or excessive
> in many cases.  For example, after IDENTIFY times out, there's no
> reason to wait five more seconds before retrying.

You'll crash some ATAPI CD-ROM drives without that delay - at least for
PATA. As in power cycle required to get it back.

Perhaps we should check cable type here ?
