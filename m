From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4] ahci: move ahci_sb600_softreset to libahci.c and
 rename it
Date: Tue, 21 Jun 2011 09:17:24 +0200
Message-ID: <BANLkTik-L1MNQspeaMhfxe4Uy1YGV+t6FA@mail.gmail.com>
References: <20110617120704.GH2611@htj.dyndns.org>
	<1308557202-1895-1-git-send-email-yuanlmm@gmail.com>
	<20110620081937.GN2611@htj.dyndns.org>
	<BANLkTinYh7doQt_6E7zOy6obhogFxB+hMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61579 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1FUHRZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jun 2011 03:17:25 -0400
In-Reply-To: <BANLkTinYh7doQt_6E7zOy6obhogFxB+hMA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuan-Hsin Chen <yuanlmm@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sshtylyov@mvista.com, Yuan-Hsin Chen <yhchen@faraday-tech.com>

Hello,

On Tue, Jun 21, 2011 at 5:24 AM, Yuan-Hsin Chen <yuanlmm@gmail.com> wrote:
>> It would be better if the name reflects that it's not for specific
>> workaround.
>
> Do you mean it would be better to name it for specific workaround?

Yes, I meant that. An extra 'not' there.

> How about ahci_bad_pmp_check_ready? Because this function is
> to avoid checking TFDATA if BAD PMP is found.

It's minor anyway and I don't think it matters all that much as long
as we make the actual reset and ops names not too confusing.

Thank you.

-- 
tejun
