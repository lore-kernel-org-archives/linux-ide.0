From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [2.6.30.5] Diagnosing an IDE lockup with SMART long tests
Date: Wed, 2 Sep 2009 08:42:20 -0600
Message-ID: <51f3faa70909020742g19007084j19a0ed071aaeffdf@mail.gmail.com>
References: <6661.1251822466@nice.ram.loc> <4A9DF3E9.9090309@gmail.com>
	 <20090902111927.GA4590@chram.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f201.google.com ([209.85.222.201]:41672 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbZIBOmT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Sep 2009 10:42:19 -0400
In-Reply-To: <20090902111927.GA4590@chram.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raphael Manfredi <Raphael_Manfredi@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Sep 2, 2009 at 5:19 AM, Raphael
Manfredi<Raphael_Manfredi@pobox.com> wrote:
> Quoting Robert Hancock:
>> It's most likely a bug in the IDE code somewhere, but realistically =
the
>> most effective course of action would likely be to switch from the o=
ld IDE
>> drivers and use libata instead. The IDE code doesn't receive that mu=
ch
>> testing these days, and it's really hard to debug (as you've seen, t=
he
>> debugging output is rather atrocious).
>
> I gave it a shot anyway. =A0Converting to PATA was surprisingly strai=
ghforward.
>
> Anyway, I now get the following when running SMART long tests on /dev=
/sda:
>
> =A0ata1: lost interrupt (Status 0x50)
>
> And the machine hangs... =A0So I'm back to square one.
> How do I prevent lockups on the system when running SMART long tests?

Can you post what particular command you're running to run the SMART
test, and also the full dmesg output from bootup? Also CCing
linux-ide.
