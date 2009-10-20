From: Tejun Heo <tj@kernel.org>
Subject: Re: disk with ata_piix freezes
Date: Tue, 20 Oct 2009 18:50:20 +0900
Message-ID: <4ADD87DC.6080604@kernel.org>
References: <4ADC5BD9.4060907@gmx.net> <4ADD176E.1090609@kernel.org> <4ADD729B.9020909@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50447 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbZJTJtG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Oct 2009 05:49:06 -0400
In-Reply-To: <4ADD729B.9020909@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Christoph Uhde <UhdeJC@gmx.net>
Cc: linux-ide@vger.kernel.org

Jan Christoph Uhde wrote:
>>
>> Is it a samsung laptop?  Can you please post dmidecode?
>>
> 
> Yes it is a Samsung N140

Yeah, there's another reporter reporting the same problem.  Can you
please cc yourself in the following bz and add a me too message there
and attach system information?

  http://bugzilla.kernel.org/show_bug.cgi?id=13416

This looks like an acpi problem to me but we're not sure yet.

Thanks.

-- 
tejun
