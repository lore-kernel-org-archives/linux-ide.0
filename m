From: Tejun Heo <tj@kernel.org>
Subject: Re: disk with ata_piix freezes
Date: Tue, 20 Oct 2009 10:50:38 +0900
Message-ID: <4ADD176E.1090609@kernel.org>
References: <4ADC5BD9.4060907@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38741 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932441AbZJTBtg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Oct 2009 21:49:36 -0400
In-Reply-To: <4ADC5BD9.4060907@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Christoph Uhde <UhdeJC@gmx.net>
Cc: linux-ide@vger.kernel.org

Jan Christoph Uhde wrote:
> with acpi=off it seems to work, probably i just thought that i had
> tested that option as well and just tried strict, ht, ...
> Unfortunately this options causes the video card to fail under X ...
> 
> Is there any way to disable acpi for ide only? How do i identify the
> acpi event and ask the piix driver to dismiss the command?
> 
> At the moment i am a bit unsure whether this is an ide or acpi problem:(

Is it a samsung laptop?  Can you please post dmidecode?

-- 
tejun
