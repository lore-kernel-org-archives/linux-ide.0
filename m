From: Chad Reese <kreese@caviumnetworks.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Fri, 21 Nov 2008 10:43:42 -0800
Message-ID: <4927015E.6080205@caviumnetworks.com>
References: <49261BE5.2010406@caviumnetworks.com> <4926E467.9020305@ru.mvista.com> <4926EFEE.2010701@caviumnetworks.com> <4926FA97.201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4926FA97.201@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
List-Id: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
>> We need to be careful not to be anti-social by filling the FIFO.  Once 
>> the FIFO is filled other cores will be starved of I/O resources.
> 
>     It's not the first time I'm seeing this driver, so I'm familiar with the 
> trick. Altho I didn't realize that this abuses the shared write buffer.

There is a FIFO between the bootbus and the cores separate from the
normal Octeon per core write buffer. This fifo is shared will all other
cores and IO units for bootbus access. If the fifo overflows then IOs
other than the bootbus are affected.

Chad
