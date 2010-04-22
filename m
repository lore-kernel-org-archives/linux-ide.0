From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci EM message type auto detect
Date: Thu, 22 Apr 2010 17:36:20 +0200
Message-ID: <4BD06CF4.2020101@kernel.org>
References: <1271931409.3745.9.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45119 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab0DVPgy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Apr 2010 11:36:54 -0400
In-Reply-To: <1271931409.3745.9.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, hane.Huang@amd.com

Hello,

On 04/22/2010 12:16 PM, Harry Zhang wrote:
> +	/* em message type */
> +	EM_MSG_TYPE_LED		= (1 << 0), /* LED */
> +	EM_MSG_TYPE_SAFTE	= (1 << 1), /* SAF-TE */
> +	EM_MSG_TYPE_SES2	= (1 << 2), /* SES-2 */
> +	EM_MSG_TYPE_SGPIO	= (1 << 3), /* SGPIO */

Shouldn't the store/show methods be testing the above SGPIO flag?
Also, can you please move this patch before the other one?

Thanks.

-- 
tejun
