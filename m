From: Yuan-Hsin Chen <yuanlmm@gmail.com>
Subject: Re: [PATCH v4] ahci: move ahci_sb600_softreset to libahci.c and
 rename it
Date: Tue, 21 Jun 2011 11:24:12 +0800
Message-ID: <BANLkTinYh7doQt_6E7zOy6obhogFxB+hMA@mail.gmail.com>
References: <20110617120704.GH2611@htj.dyndns.org>
	<1308557202-1895-1-git-send-email-yuanlmm@gmail.com>
	<20110620081937.GN2611@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50187 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab1FUDYO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 23:24:14 -0400
In-Reply-To: <20110620081937.GN2611@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sshtylyov@mvista.com, Yuan-Hsin Chen <yhchen@faraday-tech.com>

Hello, Tejun.

On Mon, Jun 20, 2011 at 4:19 PM, Tejun Heo <tj@kernel.org> wrote:
>> +static int ahci_pmp_check_ready(struct ata_link *link)
>
> It would be better if the name reflects that it's not for specific
> workaround.

Do you mean it would be better to name it for specific workaround?
How about ahci_bad_pmp_check_ready? Because this function is
to avoid checking TFDATA if BAD PMP is found.

Thanks.

Yuan-Hsin
