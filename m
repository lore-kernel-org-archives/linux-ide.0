From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata: Add two more columns to the ata_timing table.
Date: Sat, 06 Dec 2008 23:19:20 +0300
Message-ID: <493ADE48.6050709@ru.mvista.com>
References: <4939B402.9010004@caviumnetworks.com> <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:7233 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752220AbYLFUTY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2008 15:19:24 -0500
In-Reply-To: <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Hello.

David Daney wrote:

> The forthcoming OCTEON SOC Compact Flash driver needs a few more
> timing values than were available in the ata_timing table.  I add new
> columns for write_hold and read_holdz times.  The values were obtained
> from the Compact Flash specification Rev 4.1.

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

NAK.

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index ed3f26e..95fa9f6 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
[...]
>  enum ata_xfer_mask {
> @@ -864,6 +868,8 @@ struct ata_timing {
>  	unsigned short cyc8b;		/* t0 for 8-bit I/O */
>  	unsigned short active;		/* t2 or tD */
>  	unsigned short recover;		/* t2i or tK */
> +	unsigned short write_hold;	/* t4 */
> +	unsigned short read_holdz;	/* t6z */

    Sorry for failing to notice this before but t6z is again the timing that 
the host can't control. Therefore I'm seeig no sense in its addition. I don't 
know how your driver is going to use it -- but most probably incorrectly...

MBR, Sergei

