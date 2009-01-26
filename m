From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 22:33:48 +0300
Message-ID: <497E101C.9040008@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com> <20090126190801.7d198246@lxorguk.ukuu.org.uk> <497E0EF3.2000201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3976 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752676AbZAZTdT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 14:33:19 -0500
In-Reply-To: <497E0EF3.2000201@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello, I wrote:

>> This is what I would favour:

>> libata: Fix CFA detection & improve version inlines

>> From: Alan Cox <alan@redhat.com>

>> Sergei Shtylyov noticed thae ata_id_is_cfa checked the wrong word for the
>> secondary CFA test and posted a patch set to improve this, but which
>> removed the version checks.

>    And did that completely correctly.

>> This patch keeps the version checks but incorporates the other 
>> suggestions
>> Sergei made including a better ata version check for the usual case where
>> we want to know "is version >= x" rather than "what version do you
>> support".

>    Improvements should be mixed with fixes.

    Should not be, I meant to type.

WBR, Sergei

