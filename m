From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [Patch 1/1 v3 RESEND] sata_via.c: Remove redundant device ID
 for VIA VT8261
Date: Tue, 03 Nov 2009 16:17:46 -0500
Message-ID: <4AF09DFA.2010503@garzik.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB80A353BCF@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59991 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbZKCVRp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Nov 2009 16:17:45 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB80A353BCF@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk, tj@kernel.org

On 11/02/2009 06:36 AM, JosephChan@via.com.tw wrote:
> Re-send.
>
> Just remove redundant device ID for VIA VT8261.
> The device ID 0x9000 and 0x9040 are redundant (for VT8261).
> The 0x9040 is reserved for other usage.
>
> Signed-off-by: Joseph Chan<josephchan@via.com.tw>

applied


