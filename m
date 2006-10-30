From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: sata_promise TX2/TX4 cards rejecting smart auto-offline & auto-save ata cmds?
Date: Mon, 30 Oct 2006 02:31:47 -0500
Message-ID: <76366b180610292331t6827f0ddl54ffe24be39dea2c@mail.gmail.com>
References: <76366b180610292250n400fff81s76a2a9cd84d61366@mail.gmail.com>
	 <4545A74E.8020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:1171 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161169AbWJ3Hbs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 02:31:48 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1065201ugm
        for <linux-ide@vger.kernel.org>; Sun, 29 Oct 2006 23:31:47 -0800 (PST)
In-Reply-To: <4545A74E.8020604@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10/30/06, Tejun Heo <htejun@gmail.com> wrote:
> Please read the following thread.
>
> http://thread.gmane.org/gmane.linux.ide/13222/focus=13235

Worked like a charm! Just patched up smartmontools now and I don't get
the failed cmds anymore. Hope Bruce takes that patch soon.

Thanks -Andrew
