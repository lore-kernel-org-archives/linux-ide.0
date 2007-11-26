From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2/2] ide-scsi: use print_hex_dump from <linux/kernel.h>
Date: Mon, 26 Nov 2007 08:54:04 -0800
Message-ID: <474AFA2C.5080800@oracle.com>
References: <1196061373-6394-1-git-send-email-crquan@gmail.com> <1196062867.8948.25.camel@localhost> <91b13c310711260037o7af4b11dt389bb209a075c25a@mail.gmail.com> <20071126132513.GA3230@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20071126132513.GA3230@parisc-linux.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: rae l <crquan@gmail.com>, Joe Perches <joe@perches.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> On Mon, Nov 26, 2007 at 04:37:50PM +0800, rae l wrote:
>> I know this is different from the original hexdump in ide-scsi.c, I
>> just want to tell someone that there's a good implementation of
>> hexdump in kernel.h, and I think the default KERN_DEBUG and
>> print_hex_dump is more informative and has better output. However,
>> anyone want more precise control on debug message could make her/his
>> improvements with print_hex_dump.
> 
> using KERN_DEBUG is wrong -- this is part of a line, so you need to use
> KERN_NONE or simply "".

s/KERN_NONE/KERN_CONT/ for continuation lines.

-- 
~Randy
