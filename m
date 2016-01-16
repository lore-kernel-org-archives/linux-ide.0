From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] libata: disable forced PORTS_IMPL for >= AHCI 1.3
Date: Sat, 16 Jan 2016 13:09:37 +0300
Message-ID: <569A16E1.7010708@cogentembedded.com>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
 <20160114223732.GG3520@mtj.duckdns.org>
 <20160115201305.GN3520@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33949 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbcAPKJo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jan 2016 05:09:44 -0500
Received: by mail-lf0-f47.google.com with SMTP id 17so93810621lfz.1
        for <linux-ide@vger.kernel.org>; Sat, 16 Jan 2016 02:09:44 -0800 (PST)
In-Reply-To: <20160115201305.GN3520@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Andy Lutomirski <luto@amacapital.net>
Cc: linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello.

On 1/15/2016 11:13 PM, Tejun Heo wrote:

> Some early controllers incorrectly reported zero ports in PORTS_IMPL
> register and the ahci driver fabricates PORTS_IMPL from the number of
> ports in those cases.  This hasn't mattered but with the new nvme
> controllers there are cases where zero PORTS_IMPL is valid and should
> be honored.
>
> Disable the workaround for >= AHCI 1.3.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Andy Lutomirski <luto@amacapital.net>
> Link: http://lkml.kernel.org/g/CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com
> ---
> Hello, Andy.
>
> Can you please see whether this one works?
>
> Thanks.
>
>   drivers/ata/libahci.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index d61740e..a91432a 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -496,8 +496,9 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>   		}
>   	}
>
> -	/* fabricate port_map from cap.nr_ports */
> -	if (!port_map) {
> +	/* fabricate port_map from cap.nr_ports for < AHCI 1.3 */
> +	if (!port_map && (!(vers >> 16) ||
> +			  ((vers >> 16) == 1 && (vers & 0xFFFF) < 0x300))) {

     Hm, won't just (vers < 0x1300) just work?

MBR, Sergei

