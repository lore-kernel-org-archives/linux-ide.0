From: Mark Lord <kernel@teksavvy.com>
Subject: Re: SiI3811 PATA->SATA bridge not working on OpenRD-Base
Date: Mon, 14 Dec 2009 20:02:47 -0500
Message-ID: <4B26E037.1050002@teksavvy.com>
References: <20091113212332.GD1965@twin.sascha.silbe.org> <4B14B2C8.6080002@kernel.org> <20091214195909.GB29549@twin.sascha.silbe.org> <4B26C539.1030202@kernel.org> <4B26DD78.6030509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:1891 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757449AbZLOBC5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 20:02:57 -0500
In-Reply-To: <4B26DD78.6030509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Silbe <sascha-ml-reply-to-2009-4@silbe.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Ahh.. here it is:

http://patchwork.ozlabs.org/patch/40428/

Does that help/fix the issue?
