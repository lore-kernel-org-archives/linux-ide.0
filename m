From: Gregory Brauer <greg@wildbrain.com>
Subject: Re: SATA300 TX4 + WD2500KS = status=0x50 { DriveReady SeekComplete
 }
Date: Tue, 19 Dec 2006 09:52:36 -0800
Message-ID: <458826E4.1030806@wildbrain.com>
References: <200612191424.kBJEO7bD007303@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wildbrain.com ([209.130.193.228]:57738 "EHLO
	hermes.wildbrain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932849AbWLSSI2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 13:08:28 -0500
In-Reply-To: <200612191424.kBJEO7bD007303@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mikael Pettersson <mikpe@it.uu.se>, Roel.Teuwen@advalvas.be

Mikael Pettersson wrote:
> I was looking briefly at the port mapping issue on 4-port Promise controllers
> yesterday and noticed a bit of programming magic in Promise's driver that
> Linux doesn't do, and which affects two of the four ports. That _could_
> explain your issues.
> 
> /Mikael

Just as a note, I filed the issue that this thread is about as a
kernel bug:

http://bugzilla.kernel.org/show_bug.cgi?id=7516

I am also experiencing the port-mapping issue you mention with
the SATA300 TX4, but I believe that the port mapping problem and
the excess status messages are separate and unrelated problems.

Greg
